//get nasa picture of the day
function nasaAPOD(){
    //API URL Created
    let KEY = document.getElementsByName("nasaAPIAPOD")[0].value;
    const nasaURL = "https://api.nasa.gov/planetary/apod?api_key="+KEY;
    console.log(nasaURL);

    //Attempt to fetch API data
    fetch(nasaURL)
        .then(response=>{
            if(!response.ok){
                throw new Error("Bad response");
            }
            console.log("Response fetched");
            return response.json();            
        })
        .then(data=> {
            console.log("Data received");
            //const nasaJSON = response.json();
            //let imageURL = data.hdurl;
            document.getElementById("nasaImage").setAttribute("src", data.url);
            console.log(data);
        })
        .catch(error=> {
            console.log("error", error);
            window.alert("Data not received");
    })
}
function nasaNeo(){
    let KEY = document.getElementsByName("nasaAPINeo")[0].value;
    let start_date = document.getElementsByName("txtStartDate")[0].value;

    const nasaURL = 'https://api.nasa.gov/neo/rest/v1/feed?start_date='+start_date+"&end_date="+start_date+"&api_key="+KEY;
    console.log(nasaURL);
    fetch(nasaURL)
        .then(response=>{
            if(!response.ok){
                throw new Error("Bad response");
            }
            return response.json();            
        })
        .then(data=> {
            console.log("Data received");
            document.getElementById("numObjects").innerHTML = "Number of Near Earth Objects: " + data.element_count;
            console.log(data.element_count);
        })
        .catch(error=> {
            console.log("error", error);
            window.alert("Data not received");
        })
    }
/*
function list(data, date){
    let listOfObjects = `
        <ul></ul>
        `
    let newObject = ""
    newObject = data.near_earth_object;

    listOfObjects = listOfObjects + '\n' + newObject;
}
    */