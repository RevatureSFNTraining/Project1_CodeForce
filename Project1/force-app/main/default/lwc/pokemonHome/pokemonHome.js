import { LightningElement } from 'lwc';

export default class PokemonHome extends LightningElement {
    
    async getPokemon(){
        try {var number=this.template.querySelector('.search').value}
        catch{number = 1}
        
        let mon = await fetch("https://pokeapi.co/api/v2/pokemon/"+number)
        var pokemon = await mon.json()
        console.log(pokemon)
        this.displayMon(pokemon, number)
        this.displayType(pokemon)
    }
    displayMon(pokemon, number){
        this.template.querySelector('.monPic').src ="../../staticresources/SiteSamples/pokeball.png"
        this.template.querySelector("h2").innerText = pokemon.name
        
        if (pokemon.name!==undefined){
            this.template.querySelector('.monPic').src = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+number+".png"
        }
        let stats=pokemon.stats
        var total = 0
        //I know there is a better way to code this, however i just cannot be bothered to deal with it.
        try{
        this.template.querySelector(".hp").innerText=stats[0].base_stat
        this.template.querySelector(".a").innerText=stats[1].base_stat
        this.template.querySelector(".d").innerText=stats[2].base_stat
        this.template.querySelector(".sa").innerText=stats[3].base_stat
        this.template.querySelector(".sd").innerText=stats[4].base_stat
        this.template.querySelector(".spd").innerText=stats[5].base_stat
        stats.forEach(element => {
            total+= element.base_stat
        });
        this.template.querySelector(".total").innerText=total
        }
        catch(TypeError){
        this.template.querySelector(".hp").innerText=0
        this.template.querySelector(".a").innerText=0
        this.template.querySelector(".d").innerText=0
        this.template.querySelector(".sa").innerText=0
        this.template.querySelector(".sd").innerText=0
        this.template.querySelector(".spd").innerText=0
        this.template.querySelector(".total").innerText=0
        }
        //stats[1].stat.name
        //stats[1].base_stat   
    }

    displayType(pokemon){
        try{
            
        this.template.querySelector(".typeA").innerText=pokemon.types[0].type.name
        this.styleType(this.template.querySelector(".typeA"))

        if (pokemon.types.length>1){
            this.template.querySelector(".typeB").innerText=pokemon.types[1].type.name
            this.styleType(this.template.querySelector(".typeB"))
            this.template.querySelector(".typeB").innerText=" " +pokemon.types[1].type.name
            
        }else{
            this.template.querySelector(".typeB").innerText=""
            
        }
        }
        catch{
            this.template.querySelector(".typeA").innerText=""
            this.template.querySelector(".typeB").innerText=""
        }
    }

    styleType(location){
        switch (location.innerText) {
            case "normal":
                location.style="color: #a3a38b;"
                break;
            case "fighting":
                location.style="color:#D67873;"
                break;
            case "flying": location.style="color:#C6B7F5;"
                break;
            case "poison": location.style="color:#C183C1;"
                break;
            case "ground":location.style="color:#9c8f6e;" 
                break;
            case "rock":location.style="color:#D1C17D;"
                break;
            case "bug":location.style="color:#d8f20a;"
                break;
            case "ghost":location.style="color:#A292BC;"
                break;
            case "steel":location.style="color:#82828c;"
                break;
            case "fire":location.style="color:#d6722b;"
                break;
            case "water":location.style="color:#9DB7F5;"
                break;
            case "grass":location.style="color:#7eb364;"
                break;
            case "electric":location.style="color:#fcd430;"
                break;
            case "psychic":location.style="color:#FA92B2;"
                break;
            case "ice":location.style="color:#2fc2c2;"
                break;
            case "dragon":location.style="color:#A27DFA;"
                break;
            case "dark":location.style="color:#A29288;"
                break;
            case "fairy":location.style="color:#F4BDC9;"
                break;
        }
    }

    displayPokemon(){
        this.getPokemon()
        this.displayType()

    }
}