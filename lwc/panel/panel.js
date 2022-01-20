import { LightningElement } from 'lwc';

export default class Panel extends LightningElement {

    imgUrls = 
    [ 
        "../../staticresources/SiteSamples/img/risk.jpg",
        "../../staticresources/SiteSamples/img/history.jpg", 
        "../../staticresources/SiteSamples/img/europe.jpg", 
        "../../staticresources/SiteSamples/img/pacific.jpg"
    ];

    handleClick() {
        this.template.querySelector(".content").src = this.imgUrls[ Math.floor(Math.random() * this.imgUrls.length) ];
    }
    
}