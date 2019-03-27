
import RNFS from'react-native-fs';
import SMMarkDownRender from '../MarkDownRender/SMMarkDownRender';
import MD5 from 'react-native-md5';
import {SMMarkDownConverterDelegate} from '../MarkDownRender/Converters/SMMarkDownConverter'

import {NativeModules} from 'react-native';



export default class SMMarkDownDoc extends SMMarkDownConverterDelegate{

    constructor(filePath){
        super();
        
        this.absolutePath = filePath.hasOwnProperty("localPath") ? filePath.localPath : null;
        this.davRelativePath = filePath.hasOwnProperty("davRelativePath") ? filePath.davRelativePath : null;
        this.absolutePathDir = this.absolutePath.substring(0,  this.absolutePath.lastIndexOf('/'));
        this.davRelativePathDir = this.davRelativePath.substring(0,this.davRelativePath.lastIndexOf('/'));
        this.htmlFilePath = RNFS.TemporaryDirectoryPath  + MD5.hex_md5(this.absolutePath) + '.html'
        this.fileContent = "";
        this.allRefResource = [];

        if(RNFS.exists(this.htmlFilePath)){
            RNFS.unlink(this.htmlFilePath);
        }
    }

    async loadFileContent(){
        this.fileContent = await RNFS.readFile(this.absolutePath);
        return;
    }

    /**
     * 依赖的资源文件，比如图片，gif，文件等
     */
    async dependenceResource(){
        
    }

    /**
     * 获取html内容
     * @param {*} needReloadFromFile 
     */
    async getHtmlContent(needReloadFromFile = true) {
        
        if(needReloadFromFile){
            this.fileContent = await RNFS.readFile(this.absolutePath);
        }
        
        let mdRender = new SMMarkDownRender();
        mdRender.setDelegate(this);
        let htmlContent = await mdRender.render(this.fileContent);
        // console.warn(htmlContent);
        // console.warn(this.htmlFilePath);

        await RNFS.write(this.htmlFilePath, htmlContent);

        return this.htmlFilePath;
    }

    /**
     * 保存内容到文件，并且重新渲染
     * @param {*} fileContent 
     */
    async updateContentAndSave(fileContent){
        await RNFS.write(this.absolutePath, fileContent);
        return await this.getHtmlContent();
    }

    /**
     * 更新文件内容，暂时不存盘
     * @param {*} fileContent 
     */
    async updateContent(fileContent){

        this.fileContent = fileContent;
        return await this.getHtmlContent(needReloadFromFile=false);

    }

    /**
     * 正则匹配规则
     */
    regProcessRule(){
        return [
            {
                reg:/!\[.*\]\(.\/Res\/.*\)/g,  // ![](./Res/image.png) 图片处理  /!\[.*\]\((.\/Res\/.*)\)/g
                action:"find",
                processFunc:(arrayResult) => {  

                    if(! (arrayResult instanceof Array))return;

                    arrayResult.forEach(element => {
                        let tempReg = /!\[.*\]\(.(\/Res\/.*)\)/;
                        let davFilePath = this.davRelativePathDir + tempReg.exec(element)[1].replace(/([\u4e00-\u9fa5])/g, (str) => encodeURIComponent(str) );
                        NativeModules.SMRNWebDAV.downloadFile(davFilePath).then((result)=>{
                            //刷新web页面？
                            // console.warn(result);
                        }).catch((error)=>{

                        });
                    })
                    
                }

            },
            {
                reg:/!\[.*\]\(.\/Res\/.*\)/g,
                action:"replace",
                processFunc: (arrayResult) => {
                    //返回一个字典，映射替换内容
                    let replaceMap = [];

                    if(! (arrayResult instanceof Array)) return;

                    arrayResult.forEach(element => {

                        let tempReg = /(!\[.*\]\().(\/Res\/.*\))/;
                        let replaceString = element.replace(tempReg, "$1%path%$2");
                        replaceString = replaceString.replace("%path%", "file://" + this.absolutePathDir);

                        let repalceItem = {
                            originStr: element,
                            replaceStr: replaceString
                        }
                        replaceMap.push(repalceItem);
                    });

                    return replaceMap;
                }

            }
        ];
    }
}