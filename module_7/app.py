import streamlit as st
import numpy as np
import pandas as pd
import lightfm as lf
import nmslib
import pickle
import scipy.sparse as sparse
import zipfile


def main():

    def nearest_items_nms(itemid, index, n=10):
        """Функция для поиска ближайших соседей, возвращает построенный индекс"""
        nn = index.knnQuery(item_embeddings[itemid], k=n)
        return nn

    def get_names(index):
        """
        input - idx of books
        Функция для возвращения названия товаров
        return - list of names
        """
        names = []
        for idx in index:
            if idx>0:
                names.append('Item brand:  {} '.format(name_mapper[idx]) + '  Item asin: {}'.format(brand_mapper[idx]))
            else:
                names.append('')
        return names

    def read_files(folder_name=''):
        """
        Функция для чтения файлов + преобразование к  нижнему регистру
        """
        #zr = zipfile.ZipFile(folder_name+'/ratings.zip', 'r')
		#ratings = pd.read_csv(zr.open('ratings.csv'))
		#zb = zipfile.ZipFile(folder_name+'/items.zip', 'r')
		#items = pd.read_csv(zb.open('items.csv'))
        ratings = pd.read_csv(folder_name+'/ratings.csv')
        items = pd.read_csv(folder_name+'/items.csv')
        items['brand'] = items.brand.str.lower()
        return ratings, items 

    def make_mappers():
        """
        Функция для создания отображения itemid в name
        """
        name_mapper = dict(zip(items.itemid, items.brand))
        brand_mapper = dict(zip(items.itemid, items.asin))

        return name_mapper, brand_mapper

    def load_embeddings():
        """
        Функция для загрузки векторных представлений
        """
        with open('item_embeddings_rec.pickle', 'rb') as f:
            item_embeddings = pickle.load(f)

        # Тут мы используем nmslib, чтобы создать наш быстрый knn
        nms_idx = nmslib.init(method='hnsw', space='cosinesimil')
        nms_idx.addDataPointBatch(item_embeddings)
        nms_idx.createIndex(print_progress=True)
        return item_embeddings,nms_idx


    #Загружаем данные
    ratings, items  = read_files(folder_name='data') 
    name_mapper, brand_mapper = make_mappers()
    item_embeddings,nms_idx = load_embeddings()

    # Создадим приветственную форму, попросим пользователя ввести данные о товаре

    #Форма для ввода текста
    brand = st.text_input('Product brand', '')
    brand = brand.lower()

    #Наш поиск по товарам
    output = items[items.brand.str.contains(brand) > 0]

    #Выбор категории из списка
    option = st.selectbox('Which brand?', output['brand'].values)

    #Выводим бренд
    'You selected: ', option

    #Ищем рекомендации
    val_index = output[output['brand'].values == option].itemid
    index = nearest_items_nms(val_index, nms_idx, 5)

    #Выводим рекомендации
    'Most simmilar books are: '
    st.write('', get_names(index[0])[1:])


if __name__ == "__main__":
    main()
