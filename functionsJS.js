//get nasa picture of the day
function nasa(){
    //API URL Created
    let KEY = document.getElementsByName("nasaAPI")[0].value;
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
            document.getElementById("nasaImage").setAttribute("src", data.hdurl);
            console.log(data);
        })
        .catch(error=> {
            console.log("error", error);
            window.alert("Data not received");
    })
}