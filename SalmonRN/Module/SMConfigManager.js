import RNFS from'react-native-fs';

export default class SMConfigManager {

    static getInstance(){
        if(!this.instance){
            this.instance = new SMConfigManager();
        }
        return this.instance;
    }


    constructor(){
        this.webDAVConfig = {

            root:"https://dav.jianguoyun.com/dav",
            user:"zhou921803@163.com",
            password:"axwdkcia37x6j4ed"

        }

        this.localStorageRootPath = RNFS.DocumentDirectoryPath;
        this.htmlCachePath = RNFS.DocumentDirectoryPath;

        this.webServerPort = 9090;
        this.webServerRootPath = `http://127.0.0.1:${this.webServerPort}`;
    }
}