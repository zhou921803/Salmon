"use strict";

import { WebView } from 'react-native-webview';
import React from 'react';

export default class SMWebView extends React.Component {



    constructor(props){
        super(props);

    }

    /*
    * 本地处理
    */
    localProcess(request){

        if(request.url.startsWith("../") || request.url.startsWith("./")){  //本地文档跳转
            this.processLocalUrlJump(request.url);
            return true;
        } 

    }

    processLocalUrlJump(relativeUrl){
        
    }




    render(){
        return (
        <WebView 
            {...this.props} 
            useWebKit={true}
            onShouldStartLoadWithRequest={(request)=>{
                
                return this.localProcess(request) ? false : true;
            }}
        >
        </WebView>
        );
    }
}