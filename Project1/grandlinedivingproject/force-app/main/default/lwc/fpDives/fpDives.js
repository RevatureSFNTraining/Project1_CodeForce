import { LightningElement, track } from 'lwc';

export default class fpDives extends LightningElement {
    // @track imgsrctwo;
    // @track imgsrc;

    renderedCallback() {
        this.imgsrc = this.template.querySelector('[data-id="A"]');
        this.imgsrctwo = this.template.querySelector('[data-id="B"]');
    }

    page = 1;
    divetitle = 'Cave Diving';
    diveinfotextp1 = `The Grand Line houses one of the richest in underwater cave formations in the world. Its coastline is home to the largest and longest underwater caves with the recently discovered  insert cool cave name  declared the largest cave in the area and Aureo Rodger – the second largest underwater cave in the world. The professional cave divers from Ko’ox Diving will be looking out for your safety while you are granted the opportunity to explore all the history preserved in every corner of these ancient local caves.`;
    diveinfotextp2 = `You will have the unique chance to dive guided by world famous cave dive explorers: Nick Toussaint and Jesus Guzman Diaz (Chucho), founders of dive certification organizations, with own diving equipment line, hundreds of cave dives and exploration projects for National Geographic and Lonely Planet.`;

    handlePrevious() {
        if (this.page > 1) {
            this.page = this.page - 1;
            this.myTextSetter(this.page);
        }
    }

    handleNext() {
        if (this.page < 2) {
            this.page = this.page + 1;
            this.myTextSetter(this.page);
        }
    }

    myTextSetter(pg) {
        let pages = pg;

        switch (pages) {
            case 1:
                this.diveinfotextp1 = `The Grand Line houses one of the richest in underwater cave formations in the world. Its coastline is home to the largest and longest underwater caves with the recently discovered  insert cool cave name  declared the largest cave in the area and Aureo Rodger – the second largest underwater cave in the world. The professional cave divers from Ko’ox Diving will be looking out for your safety while you are granted the opportunity to explore all the history preserved in every corner of these ancient local caves.`;
                this.diveinfotextp2 = `You will have the unique chance to dive guided by world famous cave dive explorers: Nick Toussaint and Jesus Guzman Diaz (Chucho), founders of dive certification organizations, with own diving equipment line, hundreds of cave dives and exploration projects for National Geographic and Lonely Planet.`;
                // this.imgsrc.src = '../../../staticresources/cavedive1.jpg';
                // this.imgsrctwo.src = '../../../staticresources/cavedive2.jpg';
                this.divetitle = 'Cave Diving';
                break;
            case 2:
                this.diveinfotextp1 = `The ocean floor next to our diving location is littered with sunken pirate vessels making for an ideal wreck driving trip. It is reputed as the "pirate's graveyard" and it is said that many years ago the sea and landmarks here possessed an unpredictable phenomena that are not seen anywhere else in the world, many of which made sailing extremely difficult. 
                The Grand Line used to be the home of some of the world's most notorious pirates, including the past era's "Pirate King".
                We at Grand Line Diving Inc. offer an exclusive look into these fallen vessels and an unforgettable experience as we gain a glimpse into the long past Pirate Era.`;
                this.diveinfotextp2 = `They don’t call it the Grand Line for nothing: beyond its pink-sand beaches is an ocean floor that’s loaded with ships that met their end. Divers can spend weeks here and not experience them all, but some of the most frequented sites include L'Herminie, a French warship that sank in 1837. The vessel rests in 35 feet below the surface, and contains cannons, pottery, cannon balls, and bottles. Some divers even find an occasional coin or two. Two other popular sites are the Constellation Cristobal Colon, an enormous luxury liner, and Xing Da`;
                this.divetitle = 'Wreck Driving';
                // this.imgsrc.src = '../../../staticresources/shipwreck.png';
                // this.imgsrctwo.src = '../../../staticresources/shipwreck2.png';
                break;
            default:
                this.diveinfotext = 'there was an error!';
        }
    }
}
