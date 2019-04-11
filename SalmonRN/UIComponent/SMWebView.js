"use strict";

import {View, TouchableOpacity, NativeModules, StyleSheet, Image, Linking} from 'react-native';
import { WebView } from 'react-native-webview';
import React from 'react';
// isLocalServerPath
import SMPathConverter from '../Module/SMPathConverter';
import {SMFileBrowserEvent} from './SMFileBrowserEvent';
import {SMMarkDownDocEvent} from '../Module/SMMarkDownDocEvent';
// import console = require('console');
const PropTypes = require('prop-types');

export default class SMWebView extends React.Component {

    static propTypes = {
        ...View.propTypes,
        htmlInfo: PropTypes.object
    }

    constructor(props){
        super(props);

        this.state={
            htmlInfo:props.htmlInfo
        }

        this.webViewTag = "webViewTag";
        this.canGoBack = false;
    }

    componentDidMount(){
        
        SMMarkDownDocEvent.DownloadResourceCompleted.add(this._resourceDownloaded);
        // console.warn("webview componentDidMount", SMMarkDownDocEvent.DownloadResourceCompleted);
    }
    componentWillUnmount(){
        // console.warn("webview componentWillUnmount");
        SMMarkDownDocEvent.DownloadResourceCompleted.remove(this._resourceDownloaded);
    }

    _resourceDownloaded = ()=> {
        // console.warn("reload web");
        this.refs[this.webViewTag].reload();
    }

    /*
    * 本地处理
    */
    localProcess(request){

        if(SMPathConverter.getInstance().isLocalServerPath(request.url)) {

            if(request.url.indexOf(".html") == -1){
                // console.warn("process local jump");
                // console.warn(request.url, this.state.htmlInfo.httpUrl.replace(/([\u4e00-\u9fa5])/g, (str) => encodeURIComponent(str) ));
                return this.processLocalUrlJump(request.url);
            }
            return false
        }
        
        // Linking.canOpenURL(url).then(supported => {
        //     if (!supported) {
        //       console.log('Can\'t handle url: ' + url);
        //     } else {
        //       return Linking.openURL(url);
        //     }
        //   }).catch(err => console.error('An error occurred', err));

        return false;

    }

    processLocalUrlJump(localServerUrl){
        let webDAVRelativePath = SMPathConverter.getInstance().stripServerRootPath(localServerUrl)
        // console.warn(webDAVRelativePath);
        NativeModules.SMRNWebDAV.downloadFile(webDAVRelativePath).then((localAbsolutePath) => {
            // console.warn("downloaded");
            let filePath = {
                davRelativePath:webDAVRelativePath,
                localPath:localAbsolutePath
            }

            SMFileBrowserEvent.OpenFile.dispatch(filePath);
        }).catch((error)=> {

        });

        return true;
    }


    componentWillReceiveProps(nextProps){

        let newState = {
            htmlInfo:nextProps.htmlInfo
        }
        this.setState(newState);


    }

    // shouldComponentUpdate(nextProps, nextState){
    //     return true;
    // }

    goBack(){
        this.refs[this.webViewTag].goBack();
    }

    goForward(){
        this.refs[this.webViewTag].goForward();
    }

    reload(){
        this.refs[this.webViewTag].reload();
    }

    render(){
        return (
        <View {...this.props} style={[this.props.style,styles.container]}>
            <WebView 
                style= {styles.webView}
                ref={this.webViewTag}
                useWebKit={true}
                source={{uri:this.state.htmlInfo.httpUrl}}
                originWhitelist={['*']}
                onShouldStartLoadWithRequest={(request)=>{
                    // console.warn("onShouldStartLoadWithRequest");
                    // console.warn(request);
                    return this.localProcess(request) ? false : true;
                }}
                injectedJavaScript={
                    ``
                }
                onMessage={e=>{

                }}
                onNavigationStateChange={(webViewState)=>{
                    // console.warn('onNavigationStateChange:', webViewState.url);
                }}
            >
            </WebView>
            {/* <Button style={styles.toolBar} onPress={()=> this.goBack()} title={"后退"}></Button> */}

            <View style={styles.rightTopToolBar}>
                <TouchableOpacity style={styles.reloadButton} onPress={()=>{this.reload()}}>
                    <Image source={require('../assets/images/reload.png')} style={styles.reloadButtonImg}></Image>
                </TouchableOpacity>
            </View>
            <View style={styles.rightBottomToolBar}>
            
                <TouchableOpacity style={styles.goNextButton} onPress={()=>{this.goForward()}}>
                    <Image source={require('../assets/images/nextPage.png')} style={styles.goNextButtonImg}></Image>
                </TouchableOpacity>
                <TouchableOpacity style={styles.goBackButton} onPress={()=>{this.goBack()}}>
                    <Image source={require('../assets/images/prePage.png')} style={styles.goBackButtonImg}></Image>
                </TouchableOpacity>
            </View>
        </View>
        
        );
    }
}


const styles = StyleSheet.create({
    container: {
        flex:1,
        flexDirection: 'column',
    },
    webView: {
        flex:1
    },
    rightTopToolBar:{
        height:40, 
        width:40, 
        position:'absolute', 
        top:10,
        right:10,
    },

    reloadButton:{
        flex:1
    },
    reloadButtonImg:{
        width:40,
        height:40,
        opacity: 0.2
    },

    rightBottomToolBar:{
        height:135, 
        width:45, 
        position:'absolute', 
        bottom:10,
        right:10,
        // backgroundColor:'rgba(150, 152, 153 ,0.2)'
    },

    goNextButton:{
        flex:1
    },
    goNextButtonImg:{
        width:45,
        height:45,
        opacity: 0.2
    },
    goBackButton:{
        flex:1
    },
    
    goBackButtonImg:{
        width:45,
        height:45,
        opacity: 0.2
    }
})