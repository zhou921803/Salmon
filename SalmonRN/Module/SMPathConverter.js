

export default class SMPathConverter {

    static getInstance(){
        if(!this.instance){
            this.instance = new SMPathConverter();
        }
        return this.instance;
    }

    constructor(){
        this.localStorageRootPath = '';
        this.webServerRootPath = '';

    }


    configPath(localStorageRootPath, webServerRootPath){
        this.localStorageRootPath = localStorageRootPath;
        this.webServerRootPath = webServerRootPath;
    }

    /**
     * 本地文件路径到web服务路径， 
     * @param {*} localPath 
     */
    localPathToServerPath(localPath){
        
        return this.webServerRootPath + this.stripLocalStorageRootPath(localPath);
    }


    /**
     * 
     * @param {*} serverPath 
     */
    serverPathToLocalPath(serverPath){
        return this.localStorageRootPath + this.stripServerRootPath(serverPath);
    }

    /**
     * 本地路径剥离掉root路径
     * @param {*} localPath 
     */
    stripLocalStorageRootPath(localPath){
        // console.warn("localPath:", localPath, "localStorageRootPath", this.localStorageRootPath);
        let rootPathIndex = localPath.indexOf(this.localStorageRootPath)
        if(-1 != rootPathIndex){ //查找到了
            let relativePath = localPath.substring(rootPathIndex + this.localStorageRootPath.length);
            return relativePath;
        } else {
            return localPath;
        }
    }

    stripServerRootPath(serverPath){
        let rootPathIndex = serverPath.indexOf(this.webServerRootPath);
        if(-1 != rootPathIndex){ //查找到了
            let relativePath = serverPath.substring(rootPathIndex + this.webServerRootPath.length);
            return relativePath;
        } else {
            return serverPath;
        }
    }

    /**
     * 判断是否是本地服务的跳转
     * @param {*} serverPath 
     */
    isLocalServerPath(serverPath){
        let rootPathIndex = serverPath.indexOf(this.webServerRootPath);
        if(-1 != rootPathIndex){ //查找到了
            return true;
        }
        return false;
    }
}