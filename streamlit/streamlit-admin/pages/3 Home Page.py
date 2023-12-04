import streamlit as st

icon_image_url = "logopath.jpg"
st.set_page_config(page_title="AFRS", page_icon=icon_image_url, layout="wide")
st.markdown(
        f'<a href="http://3.39.193.100:8080/AWS/" target="_blank">홈페이지 바로가기</a>',
        unsafe_allow_html=True
    )