import SMMarkDownConverter from '../SMMarkDownConverter';
import showdown from './showdown';
import MarkDownTemplate from '../../../assets/styles/MarkDownTemplate';

export default class SMShowDownConverter extends SMMarkDownConverter{

    constructor(){
        super();

        this.converter = new showdown.Converter();
    }

    convert(){
        this.htmlContent = this.converter.makeHtml(this.markdownContent);
    }
    /**
     * 处理转换后的html内容
     */
    processAfterConvert(){

    }

    /**
     * 生成完整的html内容之前的处理
     */
    processBeforeGeneratorHtml(){

        let markdownTemplate = new MarkDownTemplate();
        markdownTemplate.content = this.htmlContent;
        this.htmlContent = markdownTemplate.render();
        
    }
}