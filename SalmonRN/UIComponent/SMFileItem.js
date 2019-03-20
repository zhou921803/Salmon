"use strict";

import React from 'react';

import {
    View, 
    TouchableOpacity,
    Text
}from 'react-native';

const PropTypes = require('prop-types');

/**
 * 单个文件
 */
export default class SMFileItem extends React.PureComponent{

    static propTypes = {
        ...View.propTypes,
        fileItem: PropTypes.string,
        onItemSelect: PropTypes.func
    }

    constructor(props){
        super(props);
        
        this.fileItem = JSON.parse(this.props.fileItem);
        // console.error(this.fileItem);
        this.state = {
            displayName: this.fileItem.displayName
        }

    }

    componentWillReceiveProps(nextProps){
        let newState = {
            displayName: nextProps.displayName
        }
        this.setState(newState);
    }
    
    onSelected(){
        if(this.props.onItemSelect){
            this.props.onItemSelect(this.fileItem);
        }
        
    }

    render(){
        return (
            <TouchableOpacity 
                {...this.props}
                onPress={this.onSelected.bind(this)}
            >
                <Text>{this.fileItem.displayName}</Text>
            </TouchableOpacity>
        );
        
    }
}