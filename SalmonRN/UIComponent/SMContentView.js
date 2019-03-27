/**
 * SMContentView 内容展示区
 */

import React from 'react';
import {View} from 'react-native';
import SMWebView from './SMWebView'
import {SMFileBrowserEvent} from './SMFileBrowserEvent';
import SMMarkDownDoc from '../Module/SMMarkDownDoc'
import {Enum} from '../lib/utils/enum';

const SupportFileType = {
    unknow:-1,
    MarkDown:0,     //Markdown 文档
    SourceCode:1,   //代码文件
    Image:2,        //图片
}

//文件类型后缀，跟上面的文件类型顺序对应
const FileTypePostFix = [
    ['.md','.MD'], 
    ['.c','.cpp', '.h','.hpp', '.m', '.mm'],
    ['.png', '.jpg', 'gif']
];

export default class SMContentView extends React.Component{
    constructor(props){
        super(props);
        this.mdDoc = null;

        this.state = {
            htmlInfo:{
                docLocalPathDir: "",
                htmlLocalPath: "",
                httpUrl:"",
            }
        };
    }

    componentDidMount(){
        SMFileBrowserEvent.OpenFile.add(this._onOpenFile);
    }

    componentWillUnmount(){
        SMFileBrowserEvent.OpenFile.remove(this._onOpenFile)
    }

    /**
     * 打开文件
     */
    _onOpenFile = (filePath) => {
        // console.warn(filePath);

        let localPath = filePath.hasOwnProperty("localPath") ? filePath.localPath : null;

        if(!localPath) return;

        let filePostFix = localPath.substring( localPath.lastIndexOf('.') );
        let fileType = SupportFileType.unknow;
        // console.warn(filePostFix, fileType);
        FileTypePostFix.some((postFixArray, index) => {
            // console.warn(index, postFixArray);

            if(-1 != postFixArray.indexOf(filePostFix)){
                fileType = index;
                // console.warn("finded ", fileType);
                return true;
            }
        });

        if(SupportFileType.MarkDown == fileType){
            this._OpenMarkDown(filePath);
        } else if(SupportFileType.SourceCode == fileType){
            console.warn("Can Not Open SourceCode File");
        } else if(SupportFileType.Image == fileType){
            console.warn("Can Not Open Image File");
        }

    }

    _OpenMarkDown(filePath){

        // console.warn("_OpenMarkDown");

        this.mdDoc = new SMMarkDownDoc(filePath);
        
        this.mdDoc.loadFileContent().then(()=>{
            //完成文件加载
            // this.mdDoc.dependenceResource().then((result) => {
            //     //完成依赖资源分析

            // }).catch();

            this.mdDoc.getHtml(needReloadFromFile=false).then((htmlInfo)=>{
                //完成html渲染

                let newState = {
                    htmlInfo:htmlInfo
                }

    
                this.setState(newState);
            }).catch();

        }).catch((error)=>{
            console.warn(error);
        });
    }

    render(){
        
        return (
            <View 
                {...this.props}
            >
                <SMWebView style={{flex:1}} htmlInfo={this.state.htmlInfo}>
                </SMWebView>
                {/* <SMWebView style={{flex:1}} source={{html:this.state.webContent}}>
                </SMWebView> */}
            </View>
        );
    }
}