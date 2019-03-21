"use strict";

import React from 'react';
import {
    View, 
    FlatList, 
    NativeModules,
    Button,
    StyleSheet
}from 'react-native';

import RNFS from'react-native-fs';
import SMFileItem from './SMFileItem';
import {SMFileBrowserEvent} from './SMFileBrowserEvent';
const PropTypes = require('prop-types');
/**
 * 文件浏览器
 */
export default class SMFileBrowser extends React.PureComponent{

    static propTypes = {
        ...View.propTypes,
        browsePath: PropTypes.string
    }

    constructor(props){
        super(props);

        this.currentPath = this.props.browsePath;  //当前浏览的路径

        NativeModules.SMRNWebDAV.configDAV({
            "root":"https://dav.jianguoyun.com/dav",
            "user":"zhou921803@163.com",
            "password":"axwdkcia37x6j4ed",
            "localMappingPath":RNFS.DocumentDirectoryPath
        });
      
        this.state = {
            fileItems:[]
        }
    }

    componentDidMount(){
        //获取
        this.getPathProperty(this.currentPath);
    }

    getPathProperty(filePath){

        NativeModules.SMRNWebDAV.getPathProperty(filePath).then((result)=>{

            this.currentPath = filePath;

            let newState = {
                fileItems:result
            };

            this.setState(newState);

        }).catch((error) => {

        });
    }

    onFileItemSelect(fileItem){
        console.log(fileItem);
        if(fileItem.isFile){    //选择文件，打开，渲染
            //下载文件，打开文件，渲染文件，显示文件
            // SMFileBrowserEvent.OpenFile.dispatch()

            NativeModules.SMRNWebDAV.downloadFile(fileItem.relativePath).then((result) => {
                SMFileBrowserEvent.OpenFile.dispatch(result);
            }).catch((error)=> {

            });

        }else if(fileItem.isDir){   //选择文件夹，打开
            this.getPathProperty(fileItem.relativePath);
        }
    }

    onBack(){
        let superPath = this.currentPath == '/' ? '/' : this.currentPath.substring(0, this.currentPath.lastIndexOf('/'));
        this.getPathProperty(superPath);
    }

    _keyExtractor = (item, index) => item.relativePath;
    
    render(){
        return (
            <View 
                {...this.props}
            >
                <FlatList 
                    style={styles.fileBrowser}
                    data={this.state.fileItems}
                    renderItem={({item}) => <SMFileItem fileItem={item} onItemSelect={this.onFileItemSelect.bind(this)}></SMFileItem>}
                    keyExtractor={this._keyExtractor}
                >
                </FlatList>

                <Button style={styles.backButton} onPress={()=> this.onBack()} title={"后退"}></Button>
            </View>
        );
        
    }
}

const styles = StyleSheet.create({
    fileBrowser : {
        flex:1
    },
    backButton:{
        height: 30
    }
});