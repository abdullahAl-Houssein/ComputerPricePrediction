import pandas as pd
from fastapi import FastAPI
from pydantic import BaseModel
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from fastapi.middleware.cors import CORSMiddleware
from sklearn.metrics import r2_score
from sklearn.metrics import mean_squared_error
# rom sklearn.linear_model import Ridge
app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
data = pd.read_excel("priceComputers.xlsx")
data = data.drop(['Unnamed: 12', 'Unnamed: 13', 'Unnamed: 14'], axis=1)
data['ScreenSize'] = data['ScreenSize'].str.replace('INCH ', '').astype(float)
data['BatteryLife'] = data['BatteryLife'].str.replace(
    'HOUERS ', '').astype(int)
data.columns = data.columns.str.replace(' ', '')
firstHardType_dict = {
    'SSD': '1',
    'HDD': '0',
}
data['firstHardType'] = data['firstHardType'].replace(
    firstHardType_dict).astype(int)
ScreenType_dict = {
    'FHD': '1',
    'HD': '0',
}
data['ScreenType'] = data['ScreenType'].replace(ScreenType_dict).astype(int)
laptopCase_dict = {
    'New': '1',
    'Used': '0',
}
data['laptopCase'] = data['laptopCase'].replace(laptopCase_dict).astype(int)
data['firstHardSize'] = data['firstHardSize'].str.replace(' GB', '')
data['firstHardSize'] = data['firstHardSize'].str.replace(
    '1 T', '1024').astype(int)
data['GraphicCardType'] = data['GraphicCardType'].str.replace('RTX', '')
data['GraphicCardType'] = data['GraphicCardType'].str.replace('MX', '')
data['GraphicCardType'] = data['GraphicCardType'].str.replace('GTX', '')
data['GraphicCardType'] = data['GraphicCardType'].fillna('50').astype(int)

X = data[['CORI', 'Generation', 'firstHardType', 'firstHardSize', 'SizeRam',
          'BatteryLife', 'ScreenSize', 'ScreenType', 'GraphicCardType', 'laptopCase']]
y = data['price']

X_train, X_test, y_train, y_test = train_test_split(
    # 0.05 80 0.01 85
    X, y, test_size=0.01, random_state=85)

model = LinearRegression()
# model = Ridge(alpha=1.0)
model.fit(X_train, y_train)


class LaptopFeatures(BaseModel):
    data: dict  # dictionary


def clean_user_input(data):
    data['ScreenSize'] = data['ScreenSize'].str.replace(
        'INCH ', '').astype(float)
    data['BatteryLife'] = data['BatteryLife'].str.replace(
        'HOUERS ', '').astype(int)
    firstHardType_dict = {
        'SSD': '1',
        'HDD': '0',
    }
    data['firstHardType'] = data['firstHardType'].replace(
        firstHardType_dict).astype(int)
    ScreenType_dict = {
        'FHD': '1',
        'HD': '0',
    }
    data['ScreenType'] = data['ScreenType'].replace(
        ScreenType_dict).astype(int)
    laptopCase_dict = {
        'New': '1',
        'Used': '0',
    }
    data['GraphicCardType'] = data['GraphicCardType'].str.replace(
        'Built-in', '50')
    data['laptopCase'] = data['laptopCase'].replace(
        laptopCase_dict).astype(int)
    data['firstHardSize'] = data['firstHardSize'].str.replace(' GB', '')
    data['firstHardSize'] = data['firstHardSize'].str.replace(
        '1 T', '1024').astype(int)
    data['GraphicCardType'] = data['GraphicCardType'].str.replace('RTX', '')
    data['GraphicCardType'] = data['GraphicCardType'].str.replace('MX', '')
    data['GraphicCardType'] = data['GraphicCardType'].str.replace('GTX', '')
    data['GraphicCardType'] = data['GraphicCardType'].fillna('50').astype(int)
    return data

@app.post("/predict_price")
async def predict_price(features: LaptopFeatures):
    user_data = features.data
    cleaned_features = clean_user_input(pd.DataFrame([user_data]))
    laptop_price = model.predict(cleaned_features)
    AQ = model.score(X_test, y_test)
    return {"predicted_price": laptop_price[0],
            "r_squared": AQ}
