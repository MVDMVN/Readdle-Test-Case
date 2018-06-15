import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class CurrencyConverter {

    public static void main(String[] args) throws IOException {

        //Ввод данных для конвертации
        Scanner scanner = new Scanner(System.in);
        System.out.println("Введите валюту для конвертации: ");
        String toCurrency = scanner.nextLine();
        System.out.println("Введите сумму для конвертации: ");
        int amount = scanner.nextInt();

        //Отправка данных для конвертации
        CurrencyConverter currencyConverter = new CurrencyConverter();
        double result = currencyConverter.convertCurrency(amount, toCurrency);
        System.out.println("Result: " + result + " " + toCurrency.toUpperCase());
    }

    public Double convertCurrency(double amount, String toCurrency) throws IOException {
        Set<String> allowableCurrencies = new HashSet<String>();
        allowableCurrencies.add("UAH");
        allowableCurrencies.add("EUR");
        allowableCurrencies.add("GBP");

        if (allowableCurrencies.contains(toCurrency)) {

            //Обращение к API
            String apiQuery = "USD_" + toCurrency.toUpperCase();
            String urlValue = "https://free.currencyconverterapi.com/api/v5/convert?q=" + apiQuery + "&compact=ultra";
            URL url = new URL(urlValue);

            URLConnection apiConnection = url.openConnection();
            apiConnection.connect();

            //Парсинг ответа
            JsonParser jsonParser = new JsonParser();
            JsonElement jObject = jsonParser.parse(new InputStreamReader((InputStream) apiConnection.getContent()));
            JsonObject jsonObject = jObject.getAsJsonObject();
            String value = jsonObject.get(apiQuery).getAsString();

            return amount * Double.parseDouble(value);
        }
        else {
            System.out.println("Некорректная валюта или сумма");
            return null;
        }
    }
}
