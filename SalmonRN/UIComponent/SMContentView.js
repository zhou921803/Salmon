import React from 'react';
import {View} from 'react-native';

export default class SMContentView extends React.Component{
    constructor(props){
        super(props);

    }

    render(){
        return (
            <View 
                {...this.props}
            ></View>
        );
    }
}