

export default class SMMarkDownConverter {


    constructor(){
        this.markdownContent = '';
        this.htmlContent = '';
        this.delegate = null;
    }

    /**
     * 加载内容
     */
    loadContent(mdContent){this.markdownContent = mdContent;}

    /**
     * 对转换前的markdown 文本内容进行处理
     */
    processBeforeConvert(){
        if(this.delegate){

            let regs = this.delegate.regProcessRule();

            regs.forEach(element => {
                //处理每一个正则匹配

                let reg = element.hasOwnProperty("reg") ? element.reg : null;
                let action = element.hasOwnProperty("action") ? element.action : "find";
                let processFunc = element.hasOwnProperty("processFunc") ? element.processFunc : null;

                if(reg){

                    if("find" == action){   //查找动作

                        let result = this.markdownContent.match(reg);
                        let findResultProcessFunc = processFunc;
                        if(processFunc){
                            findResultProcessFunc(result);
                        }

                    } else if("replace" == action ){    //替换动作
                        let result = this.markdownContent.match(reg);
                        let getReplaceMap = processFunc;
                        if(getReplaceMap){
                            let replaceMap = getReplaceMap(result);
                            //迭代处理替换动作

                            if(! (replaceMap instanceof Array))return;

                            replaceMap.forEach(element => {
                                let originStr = element.hasOwnProperty('originStr') ? element.originStr : null;
                                let replaceStr = element.hasOwnProperty('replaceStr') ? element.replaceStr : null;
                                
                                if(originStr && replaceStr){
                                    this.markdownContent = this.markdownContent.replace(originStr, replaceStr);
                                }
                            });

                        }
                    }

                }
            });
        }
    }

    convert(){}


    /**
     * 处理转换后的html内容
     */
    processAfterConvert(){}

    /**
     * 生成完整的html内容之前的处理
     */
    processBeforeGeneratorHtml(){}

    /**
     * 生成html
     */
    generatorHtml(){return this.htmlContent}

}


export class SMMarkDownConverterDelegate{
    regProcessRule() {return [];}
}