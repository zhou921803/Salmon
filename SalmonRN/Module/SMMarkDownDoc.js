import RNFS from'react-native-fs';
import MarkdownRender from '../markdown-render/markdownRender';

export default class SMMarkDownDoc {
    constructor(absolutePath){
        this.absolutePath = absolutePath;


        this.fileCOntent = "";
        this.allRefResource = [];   

        console.warn(absolutePath);
    }

    async loadFile(){
        console.warn("1111");
        this.fileContent = await RNFS.readFile(this.absolutePath);
        console.warn("this.fileContent");
        this._analyzeFileContent();
        this._downloadNecessaryResource();

        let mdRender = new MarkdownRender();
        let result = mdRender.mdRender(this.fileContent);
        console.warn("2222");
        return result;
    }



    /**
     * 获取当前文档所有引用的 ./Res/ 下的资源
     */
    allRefResource(){

    }

    /**
     * 分析文档内容，筛选出一系列的资源，比如引用的资源，标题信息？
     */
    _analyzeFileContent() {
        this._analyzeRefResource();
    }

    _analyzeRefResource(){

    }

    /**
     * 下载一些必要的资源，比如图片，gif等
     */
    async _downloadNecessaryResource(){

    }
}