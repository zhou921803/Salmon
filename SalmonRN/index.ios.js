"use strict";

import React from "react";
import { AppRegistry, StyleSheet, Text,View, NativeModules, Menu} from "react-native";
import SideMenu from 'react-native-side-menu';
import SMContentView from './UIComponent/SMContentView';
import SMSideView from './UIComponent/SMSideView';
import Modal from 'react-native-modal'




class SalmonRNApp extends React.Component {
  
  constructor(){
    super();

    this.state ={
      isOpen:true
    }
  }

  render() {

    const menu = <SMSideView></SMSideView>;

    return (
      <SideMenu 
        menu={menu} 
        isOpen={this.state.isOpen}>
        <SMContentView style={{flex:1, backgroundColor:"#0000F0", marginTop:20}} ></SMContentView>
      </SideMenu>
    );
  }

}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#FFFF00"
  },
  highScoresTitle: {
    fontSize: 20,
    textAlign: "center",
    margin: 10
  },
  scores: {
    textAlign: "center",
    color: "#333333",
    marginBottom: 5
  }
});

// 整体js模块的名称
AppRegistry.registerComponent("SalmonRNApp", () => SalmonRNApp);