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
            webContent:"hello world"
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
        console.warn(filePath);
        this.mdDoc = new SMMarkDownDoc(filePath);

        this.mdDoc.loadFile().then( (result) => {
            //加载分析完成，显示内容
            let newState = {
                webContent:result
            }

            this.setState(newState);

        }).catch((error ) => { 
            //显示加载错误

        })
    }


    render(){
        return (
            <View 
                {...this.props}
            >
                <SMWebView style={{flex:1}} source={{html:this.state.webContent}}>
                </SMWebView>
            </View>
        );
    }
}