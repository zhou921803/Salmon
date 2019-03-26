import showdown from './showdown';


export default class MarkdownRender{
    constructor(htmlTemplate){
        
    }

    mdRender(mdContent){

        let converter = new showdown.Converter();


        let html = converter.makeHtml(mdContent);


        return html;
    }
    
}