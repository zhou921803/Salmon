/**
 * SMContentView 内容展示区
 */

import React from 'react';
import {View} from 'react-native';
import SMWebView from './SMWebView'
import {SMFileBrowserEvent} from './SMFileBrowserEvent';
import SMMarkDownDoc from '../Module/SMMarkDownDoc'

export default class SMContentView extends React.Component{
    constructor(props){
        super(props);
        this.mdDoc = null;

        this.state = {
            htmlLocalPath:""
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
        this.mdDoc = new SMMarkDownDoc(filePath);
        
        this.mdDoc.loadFileContent().then(()=>{
            //完成文件加载
            this.mdDoc.dependenceResource().then((result) => {
                //完成依赖资源分析

            }).catch();

            this.mdDoc.getHtmlContent(needReloadFromFile=false).then((htmlPath)=>{
                //完成html渲染
                let newState = {
                    htmlLocalPath:htmlPath
                }
    
                this.setState(newState);
            }).catch();

        }).catch((error)=>{
            console.warn(error);
        });

        // this.mdDoc.loadFile().then( (result) => {
        //     //加载分析完成，显示内容
        //     let newState = {
        //         webContent:result
        //     }

        //     this.setState(newState);

        // }).catch((error ) => { 
        //     //显示加载错误

        // })
    }

    render(){
        
        return (
            <View 
                {...this.props}
            >
                <SMWebView style={{flex:1}} source={{uri:this.state.htmlLocalPath}}>
                </SMWebView>
                {/* <SMWebView style={{flex:1}} source={{html:this.state.webContent}}>
                </SMWebView> */}
            </View>
        );
    }
}