package main

import (
	"time"
	"fmt"
	"encoding/json"
)

var n1,n2,n3  = 0,1,0
var correctAnswers = 0
var incorrectAnswers = 0
var currentNumber = 0

func fibNumbersCount(count int) []int  {

	var globalArray = make([]int, count)

	globalArray[0] = 0
	globalArray[1] = 1
	for i := 2; i < count; i++ {
		globalArray[i] = globalArray[i-1] + globalArray[i-2]
	}

	return globalArray

}


func main() {

	count :=  15
	var fibonacciNumbersArray = fibNumbersCount(count)


Loop:
	for i := 0; i < len(fibonacciNumbersArray); i++ {

		if correctAnswers == 10 || incorrectAnswers == 3 {
			break
		}

		timeout := time.After(10 * time.Second)

		for   {
			number := make(chan int)
			var currentNumber = 0

			go func() {

				var n int
				fmt.Println("Введите число Фибоначчи: ")

				_, err := fmt.Scanf("%d", &n)

				if err != nil {
					fmt.Println(err)
				}

				currentNumber = n
				number <- n

			}()

			select {
			case <-timeout:
				mapD := map[string]int{"Вы не ввели число в течении 10 секунд. Правильное число": fibonacciNumbersArray[i], "Позиция": i}
				json, _ := json.Marshal(mapD)
				fmt.Println(string(json))
				incorrectAnswers++
				continue Loop

			case <-number:
				if fibonacciNumbersArray[i] == currentNumber {
					fmt.Println("Правильно!")
					correctAnswers++;
					continue Loop
				} else {
					mapD := map[string]int{"Правильное число": fibonacciNumbersArray[i], "Неправильно! Позиция": i}
					json, _ := json.Marshal(mapD)
					fmt.Println(string(json))
					incorrectAnswers++;
					continue Loop
				}
				time.Sleep(1*time.Second)
			}
		}
	}
}