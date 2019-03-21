"use strict";

import React from 'react';
import {View, StyleSheet, Text} from 'react-native';
import SMFileBrowser from './SMFileBrowser';

export default class SMSideView extends React.Component{
    constructor(props){
        super(props);

    }

    render(){
        return (
            <View 
                {...this.props}
                style = {styles.container}
            >
                <Text style={styles.textTitle}>目录</Text>
                <SMFileBrowser style={styles.fileBrowser} browsePath={"/"}></SMFileBrowser>
            </View>
        );
        
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: "flex-start",
        alignItems: "stretch",
        backgroundColor: "white",
        marginTop: 20
    },

    textTitle: {
        fontSize: 20,
        height: 35,
    },

    fileBrowser: {
        flex:1
    }
})