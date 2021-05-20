# 太菜也會煮菜


| APP  | Introduction |
| ------------- | ------------- |
| ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/Logo.jpg)  | 一款ios食譜app，引導您親手做出健康美食，多樣的食譜任您挑選，輕鬆找到想找的食譜，並解決料理上的疑難雜症。


[![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/AppStore.jpg)](https://jed-4a6g0109.github.io/?fbclid=IwAR1jRB0c1QW7wCZoTWttgmf6QQZxU9JHnMdzyyMS0Obm6n-r7ZLid02Cvcc)

## 詳細介紹
Youtube
https://www.youtube.com/watch?v=ZHoiijwXpRA&ab_channel=Straw

## APP Previews


| Recipe classification | Course registration | Diet planning | member |
| --- | --- | --- | --- |
| ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61694070.jpg)   | ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61694075.jpg)     | ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61694076.jpg)    | ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61694077.jpg)    |



| random meals| consultation | Account information | Search  |
| --- | --- | --- | --- |
| ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61694081.jpg)   | ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61694080.jpg)     | ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61694079.jpg)    | ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61694078.jpg)    |




| Create account | Forgot password | Guided teaching | recipe |
| --- | --- | --- | --- |
| ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61718542.jpg)   | ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61718541.jpg)     | ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61718537.jpg)    | ![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/S__61718535.jpg)    |


## AI線上食材辨識
使用相機拍下食材圖片，透過圖片中的食材幫使用者找出食材名稱，並且顯示相關的食譜資訊。幫助使用者透過手邊的食材找到相關食譜，了解食材種類。
![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/AI_Introduction.jpg)

而本專案AI辨識實作了本地與伺服端辨識

### Edge device recognition
使用 Keras建立分類器 訓練model(驗證準確度為 80-85%)，訓練完後儲存 model 使用 Coremltools進行 model 轉換，

輸出檔案格式為 CoreML 所支援的.mlmodel，最後在Swift 上調整圖片 shape 並 predictions 取得最大向量機率後輸出 Label名稱。

![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/Core_ML_AI.jpg)



### Server recognition

透過TCP方式，在IOS把圖像轉換成base64傳輸至Flask Server進行辨識，而模型部分使用Pytorh 對YOLOv4權重進行遷移式學習，並輸出成.pth檔進行辨識

![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/AI.gif)

### Flask Server 預測
![image](https://github.com/JED-4a6g0109/Foodapp/blob/main/image/1621179720416.jpg)
