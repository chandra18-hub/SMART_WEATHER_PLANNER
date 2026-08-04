async function getWeather() {

    console.log("JavaScript is connected!");

    let city = document.getElementById("city").value;

    let apiKey = "a97496880a8726020ef27c1b9f54a982";

    let url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;

    try {

        let response = await fetch(url);

        let data = await response.json();

        console.log(data);   // <-- Put it here

        if (!response.ok) {
            throw new Error("City not found");
        }

        document.getElementById("weather").innerHTML = `
            <h2>${data.name}</h2>
            <h3>${data.main.temp} °C</h3>
            <p>${data.weather[0].description}</p>
            <p>Humidity: ${data.main.humidity}%</p>
            <p>Wind: ${data.wind.speed} m/s</p>
        `;

    } catch (error) {

        console.log(error);

        document.getElementById("weather").innerHTML =
            "<h3>❌ City not found or Invalid API Key</h3>";

    }
}