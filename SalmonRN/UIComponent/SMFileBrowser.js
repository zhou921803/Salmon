"use strict";

import React from 'react';

import {
    View, 
    FlatList, 
    NativeModules,
}from 'react-native';

import RNFS from'react-native-fs';
import SMFileItem from './SMFileItem';


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
            let newState = {
                fileItems:result
            };

            this.setState(newState);
            console.warn(result.length, result);

        }).catch((error) => {

        });
    }

    onFileItemSelect(fileItem){
        console.log(fileItem);
        if(fileItem.isFile){    //选择文件，打开，渲染

        }else if(fileItem.isDir){   //选择文件夹，打开
            this.getPathProperty(fileItem.relativePath);
        }
    }


    _keyExtractor = (item, index) => item.relativePath;
    
    render(){
        return (
            <View 
                {...this.props}
            >
                <FlatList 
                    data={this.state.fileItems}
                    renderItem={({item}) => <SMFileItem fileItem={item} onItemSelect={this.onFileItemSelect.bind(this)}></SMFileItem>}
                    keyExtractor={this._keyExtractor}
                >
                </FlatList>
            </View>
        );
        
    }
}

