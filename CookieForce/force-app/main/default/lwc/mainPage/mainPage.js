import { LightningElement } from 'lwc';

export default class MainPage extends LightningElement {
    contacts = [
        {
            Id: 1,
            Name: 'Chocolate Chip Cookie',
            Picture: '../../staticresources/SiteSamples/img/chocolatechip.jpg',
            Desc: 'A cookie with chocolate chips!',
            Show: false
        },
        {
            Id: 2,
            Name: 'Raisin Cookie',
            Picture: '../../staticresources/SiteSamples/img/raisincookie.jpg',
            Desc: 'A cookie with Raisins!',
            Show: false
        },
        {
            Id: 3,
            Name: 'Sugar Cookie',
            Picture: '../../staticresources/SiteSamples/img/sugarcookie.jpg',
            Desc: 'A cookie with sugar sprinkles!',
            Show: false
        },
        {
            Id: 4,
            Name: 'Macaron Cookie',
            Picture: '../../staticresources/SiteSamples/img/macaron.jpg',
            Desc: 'A macaron cookie!',
            Show: false
        },
        {
            Id: 5,
            Name: 'Biscotti Cookie',
            Picture: '../../staticresources/SiteSamples/img/biscotti.jpg',
            Desc: 'A biscotti cookie!',
            Show: false
        },
        {
            Id: 6,
            Name: 'Shortbread Cookie',
            Picture: '../../staticresources/SiteSamples/img/shortbread.jpg',
            Desc: 'A shortbread cookie!',
            Show: false
        },
    ];

    handleClick() {
        this.Show = !this.Show;
    }
}