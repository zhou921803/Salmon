"use strict";

import React from 'react';

import {
    View, 
    TouchableOpacity,
    Text,
    Image,
    ImageBackground,
    StyleSheet
}from 'react-native';

const PropTypes = require('prop-types');

/**
 * 单个文件
 */
export default class SMFileItem extends React.PureComponent{

    static propTypes = {
        ...View.propTypes,
        fileItem: PropTypes.object,
        onItemSelect: PropTypes.func
    }

    constructor(props){
        super(props);
        this.fileItem = this.props.fileItem;
        // console.error(this.fileItem);
        this.state = {
            displayName: this.fileItem.displayName
        }

    }

    componentWillReceiveProps(nextProps){
        this.fileItem = nextProps.fileItem;
        let newState = {
            displayName: this.fileItem.displayName
        }
        this.setState(newState);
    }
    
    onSelected(){
        if(this.props.onItemSelect){
            this.props.onItemSelect(this.fileItem);
        }
        
    }

    render(){
        let iconImage = this.fileItem.isFile ? require('../assets/file.png') : require('../assets/dir.png')
        return (
            <TouchableOpacity 
                {...this.props}
                style = {styles.container}
                onPress={this.onSelected.bind(this)}
            >
                <Image source={iconImage} style={styles.icon}></Image>
                <Text >{this.fileItem.displayName}</Text>
            </TouchableOpacity>
        );
        
    }
}

const styles = StyleSheet.create({
    container:{
        flexDirection:'row',
        justifyContent:'flex-start',
        alignItems:'center',
        backgroundColor:'white',
        height: 25
    },
    icon:{
        height: 16,
        width: 16
    },
    displayName:{
        flex:1,
        paddingLeft:5
    }
})