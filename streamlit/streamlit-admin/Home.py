import streamlit as st

icon_image_url = "logopath.jpg"
st.set_page_config(page_title="AFRS", page_icon=icon_image_url, layout="wide")
st.title("")




# 이미지를 가운데로 정렬하기 위한 CSS 스타일
style = """
    <style>
        div.stImage {
            display: flex;
            justify-content: center;
        }
    </style>
"""

# 스타일 적용
st.markdown(style, unsafe_allow_html=True)

# 이미지 추가 및 크기 조절
image_path = ".\뉴로고.jpg"
st.image(image_path, width=600)  # 이미지의 폭을 조절하여 크기를 조절
