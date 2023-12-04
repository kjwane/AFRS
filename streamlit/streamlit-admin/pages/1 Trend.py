
import streamlit as st
import pandas as pd
import plotly.express as px
from streamlit_option_menu import option_menu
from numerize.numerize import numerize
import time
from streamlit_extras.metric_cards import style_metric_cards
st.set_option('deprecation.showPyplotGlobalUse', False)
import plotly.graph_objs as go
import matplotlib.pyplot as plt


#uncomment this line if you use mysql
#from query import *

st.set_page_config(page_title="Trend",page_icon="📈",layout="wide")

# Load Style css


st.header("의류 시장 트렌드 데이터 분석 | 상품, 지역, 연령대별 ")

#all graphs we use custom css not streamlit 
theme_plotly = None 


# load Style css
with open('style.css')as f:
    st.markdown(f"<style>{f.read()}</style>", unsafe_allow_html = True)



# 엑셀 파일 경로


# 엑셀 파일 불러오기
df = pd.read_excel('./통합 문서3.xlsx')

# 오른쪽에 배치할 이미지
right_image = "./wordcloud15.png"

# 페이지 제목 설정
st.write("이전 구매 기록")

# 가운데 정렬을 위한 레이아웃 설정



# 왼쪽 컬럼 생성


left,right,center=st.columns(3)



# 왼쪽 컬럼에 표 추가
with left:
    st.table(df)

# ... (previous code)


dataframe3 = pd.read_excel("./data.xlsx")
# Right column with the image centered
with right:
    st.write("평점에 따른 매출액 데이터셋")
    
    st.bar_chart(data=dataframe3, x='Rating', y='Revenue', color='#ffaa00', width=0, height=0, use_container_width=True)
        





    




    






  




    

with center:

    st.image("./wordcloud15.png", width=400, caption="금주 패션 키워드")



        




        
#load excel file | comment this line when  you fetch data from mysql
df=pd.read_excel('data.xlsx', sheet_name='Sheet1')
#this function performs basic descriptive analytics like Mean,Mode,Sum  etc
def Home():
    with st.expander("- 의류 판매 트렌드 데이터셋 보기"):
        showData=st.multiselect('Filter: ',df_selection.columns,default=["Expiry","Gender","Brand","Style","Revenue","Age","Rating"])
        st.dataframe(df_selection[showData],use_container_width=True)
    
#side bar logo


#switcher

region=st.sidebar.multiselect(
    "스타일",
     options=df["Style"].unique(),
     default=df["Style"].unique()
)
location=st.sidebar.multiselect(
    "성별",
     options=df["Gender"].unique(),
     default=df["Gender"].unique()
)


df_selection = df[df["Style"].isin(region) & df["Gender"].isin(location)]





#this function performs basic descriptive analytics like Mean,Mode,Sum  etc

with st.expander("- 의류 판매 트렌드 데이터셋 보기"):
        showData=st.multiselect('Filter: ',df_selection.columns,default=["Expiry","Gender","Brand","Style","Revenue","Age","Rating"])
        st.dataframe(df_selection[showData],use_container_width=True)
    

   

#graphs
def graphs():
    #total_investment=int(df_selection["Investment"]).sum()
    #averageRating=int(round(df_selection["Rating"]).mean(),2) 
    #simple bar graph  investment by business type
    investment_by_business_type=(
        df_selection.groupby(by=["Age"]).count()[["Revenue"]].sort_values(by="Revenue")
    )
    fig_investment=px.bar(
       investment_by_business_type,
       x="Revenue",
       y=investment_by_business_type.index,
       orientation="h",
       title="<b> 연령대별 판매량 </b>",
       color_discrete_sequence=["#0083B8"]*len(investment_by_business_type),
       template="plotly_white",
    )
    fig_investment.update_layout(
     plot_bgcolor="rgba(0,0,0,0)",
     font=dict(color="black"),  
    xaxis=(dict(showgrid=True))
     )

    #simple line graph investment by state
    investment_state=df_selection.groupby(by=["Brand"]).count()[["Revenue"]]
    fig_state=px.line(
       investment_state,
       x=investment_state.index,
       y="Revenue",
       orientation="v",
       title="<b> 브랜드별 판매량 </b>",
       color_discrete_sequence=["#0083b8"]*len(investment_state),
       template="plotly_white",
    )
    fig_state.update_layout(
    xaxis=dict(tickmode="linear"),
    plot_bgcolor="rgba(0,0,0,0)",
    yaxis=(dict(showgrid=False))
     )

    left,right,center=st.columns(3)
    left.plotly_chart(fig_state,use_container_width=True)
    right.plotly_chart(fig_investment,use_container_width=True)
    
    with center:
      #pie chart
      fig = px.pie(df_selection, values='Rating', names='Style', title='<b>스타일별 판매비율</b>')
      fig.update_layout(legend_title="스타일", legend_y=0.9)
      fig.update_traces(textinfo='percent+label', textposition='inside')
      st.plotly_chart(fig, use_container_width=True, theme=theme_plotly)






#function to show current earnings against expected target     
def Progressbar():
    st.markdown("""<style>.stProgress > div > div > div > div { background-image: linear-gradient(to right, #99ff99 , #FFFF00)}</style>""",unsafe_allow_html=True,)
    target=3000000000
    current=df_selection["Revenue"].sum()
    percent=round((current/target*100))
    mybar=st.progress(0)

    if percent>100:
        st.subheader("Target done !")
    else:
     st.write("you have ",percent, "% " ,"of ", (format(target, 'd')), "TZS")
     for percent_complete in range(percent):
        time.sleep(0.1)
        mybar.progress(percent_complete+1,text=" Target Percentage")


#menu bar
def sideBar():
 with st.sidebar:
    selected=option_menu(
        menu_title="Main Menu",
        options=["Home","Progress"],
        icons=["house","eye"],
        menu_icon="cast",
        default_index=0
    )
 if selected=="Home":
    #st.subheader(f"Page: {selected}")
    graphs()
 if selected=="Progress":
    #st.subheader(f"Page: {selected}")
    Progressbar()
    graphs()




sideBar()
st.sidebar.image("./뉴로고.jpg",caption="")






