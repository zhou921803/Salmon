import SMShowDownConverter from './Converters/ShowDown/SMShowDownConverter';

export default class SMMarkDownRender {

    constructor(){
        this.markdownConverter = new SMShowDownConverter();
    }
    

    setDelegate(delegate){
        this.markdownConverter.delegate = delegate;
    }
    /**
     * 渲染可能会比较耗时，执行异步操作
     * @param {*} mdcontent 
     */
    async render(mdcontent){
        this.markdownConverter.loadContent(mdcontent);  
        this.markdownConverter.processBeforeConvert(); 
        this.markdownConverter.convert();           
        this.markdownConverter.processAfterConvert();               
        this.markdownConverter.processBeforeGeneratorHtml();                
        return this.markdownConverter.generatorHtml();  //生成完整的html
    }
}

