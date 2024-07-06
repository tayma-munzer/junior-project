import asyncio
import websockets
import json
import base64
import os
import requests
import numpy as np 
from scipy.spatial.distance import cosine
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

VIDEO_DIR = 'storage/videos/'
IMAGE_DIR = 'storage/images/'
WORK_DIR = 'storage/works/'
async def add_medias(websocket):
    async for message in websocket:
        data = json.loads(message)
        print(data['c_id'])
        medias = data['medias']
        medias2=[]
        for media in medias :
            m_name = media['m_name']
            m_data = media['m_data']
            m_bytes = base64.b64decode(m_data)
            video_path = os.path.join(VIDEO_DIR, m_name)

            with open(video_path, 'wb') as file:
                file.write(m_bytes)
            print(f"Saved video: {m_name}")
            m= {'m_name':m_name,'m_title':media['m_title'],'m_desc':media['m_desc']}
            medias2.append(m)
        data = {'c_id':data['c_id'],'medias':medias2}
        headers = {
        "Content-Type": "application/json"
        }
        response = requests.post('http://127.0.0.1:8000/api/add_media', data=json.dumps(data), headers=headers)
        print(response.text)
        await websocket.send(response.text)
        


async def get_course_video(websocket):
    async for message in websocket:
        data = json.loads(message)
        m_id = data['m_id']
        print("recieve : ")
        print(message)
        data = {'m_id': m_id}
        response = requests.post('http://127.0.0.1:8000/api/get_media', data=data)
        print(response.text)
        data = json.loads(response.text)
        video_name = data[0]['m_name']
        video_path = os.path.join(VIDEO_DIR, video_name)

        if os.path.exists(video_path):
            with open(video_path, 'rb') as video_file:
                video_bytes = video_file.read()
            # I have send twice for a simple reason to make the data about the video appear before the video because the video could take long time
            response = {
                'm_id': data[0]['m_id'],
                'm_name': data[0]['m_name'],
                'm_title': data[0]['m_title'],
                'm_desc':data[0]['m_desc'],
                'bytes': list(),
                'c_id':data[0]['c_id']
            }
            print("start sending")
            await websocket.send(json.dumps(response))
            print("done sending")
            response = {
                'm_id': data[0]['m_id'],
                'm_name': data[0]['m_name'],
                'm_title': data[0]['m_title'],
                'm_desc':data[0]['m_desc'],
                'bytes': list(video_bytes),
                'c_id':data[0]['c_id']
            }
            print("start sending")
            await websocket.send(json.dumps(response))
            print("done sending")
        else:
            print(f"Video file '{video_name}' not found.")


async def search(websocket):
    async for message in websocket:
        data = json.loads(message)
        search_string = data['search_string']
        response = requests.get('http://127.0.0.1:8000/api/get_all_services')
        services = json.loads(response.text)
        response = requests.get('http://127.0.0.1:8000/api/get_all_courses')
        courses = json.loads(response.text)
        response = requests.get('http://127.0.0.1:8000/api/get_all_jobs')
        jobs = json.loads(response.text)
        vectorizer = CountVectorizer()
        services_cos_list = []
        courses_cos_list = []
        jobs_cos_list = []
        for service in services :
            X = vectorizer.fit_transform([search_string, service['s_name']])
            cosine_sim = cosine_similarity(X[0], X[1])[0][0]
            services_cos_list.append([cosine_sim,service])
        for course in courses :
            X = vectorizer.fit_transform([search_string, course['c_name']])
            cosine_sim = cosine_similarity(X[0], X[1])[0][0]
            courses_cos_list.append([cosine_sim,course])
        for job in jobs :
            X = vectorizer.fit_transform([search_string, job['j_title']])
            cosine_sim = cosine_similarity(X[0], X[1])[0][0]
            jobs_cos_list.append([cosine_sim,job])
        service_sorted_list = sorted(services_cos_list, key=lambda x: x[0], reverse=True)
        course_sorted_list = sorted(courses_cos_list, key=lambda x: x[0], reverse=True)
        job_sorted_list = sorted(jobs_cos_list, key=lambda x: x[0], reverse=True)
        returned_services = [item[1] for item in service_sorted_list]
        returned_courses = [item[1] for item in course_sorted_list]
        returned_jobs = [item[1] for item in job_sorted_list]
        print("\n\n services\n\n")
        for item in returned_services:
            print(item)
        print("\n\n courses\n\n")
        for item in returned_courses:
            print(item)
        print("\n\n jobs\n\n")
        for item in returned_jobs:
            print(item)
        response = { 
            'services':returned_services,
            'courses' :returned_courses,
            'jobs':returned_jobs
        }
        print("start sending")
        await websocket.send(json.dumps(response))
        print("done sending")

        
async def add_works(websocket):
    async for message in websocket:
        data = json.loads(message)
        s_id = data['s_id']
        w_name = data['w_name']
        w_data = data['w_data']
        w_desc = data['w_desc']
        w_bytes = base64.b64decode(w_data)
        work_path = os.path.join(WORK_DIR, w_name)
        if not os.path.exists(WORK_DIR):
            os.makedirs(WORK_DIR)
        with open(work_path, 'wb') as file:
            file.write(w_bytes)
        print(f"Saved video: {w_name}")
        msg = {'w_name':w_name,'w_desc':w_desc,'s_id':s_id}
        print(msg)
        headers = {
        "Content-Type": "application/json"
        }
        response = requests.post('http://127.0.0.1:8000/api/add_work', data=json.dumps(msg),headers=headers)
        print(response.text)
        await websocket.send(response.text)

async def get_works(websocket):
    async for message in websocket:
        data = json.loads(message)
        s_id = data['s_id']
        print("recieve : ")
        print(message)
        data = {'s_id': s_id}
        response = requests.post('http://127.0.0.1:8000/api/get_works', data=data)
        print(response.text)
        data = json.loads(response.text)
        works = []
        for work in data :
            s_id = work['s_id']
            w_name = work['w_name']
            w_desc = work['w_desc']
            work_path = os.path.join(WORK_DIR, w_name)
            if os.path.exists(work_path):
                with open(work_path, 'rb') as work_file:
                    work_bytes = work_file.read()
                w = {'w_name':w_name,'w_desc':w_desc,'s_id':s_id , 'w_bytes':list(work_bytes)}
                works.append(w)
            else:
                print(f"work file '{w_name}' not found.")
        print(works)
        msg = {'works':works}
        print("start sending")
        await websocket.send(json.dumps(msg))
        print("done sending")


async def job_search(websocket):
    async for message in websocket:
        data = json.loads(message)
        search_string = data['search_string']
        courses = json.loads(response.text)
        response = requests.get('http://127.0.0.1:8000/api/get_all_jobs')
        jobs = json.loads(response.text)
        vectorizer = CountVectorizer()
        jobs_cos_list = []
        for job in jobs :
            X = vectorizer.fit_transform([search_string, job['j_title'], job['j_desc'], job['j_education'], job['j_req']])
            cosine_sim_title = cosine_similarity(X[0], X[1])[0][0]
            cosine_sim_desc = cosine_similarity(X[0], X[2])[0][0]
            cosine_sim_education = cosine_similarity(X[0], X[3])[0][0]
            cosine_sim_req = cosine_similarity(X[0], X[4])[0][0]
            avg_cosine_sim = (cosine_sim_title + cosine_sim_desc + cosine_sim_education + cosine_sim_req) / 4
            jobs_cos_list.append([avg_cosine_sim,job])
        job_sorted_list = sorted(jobs_cos_list, key=lambda x: x[0], reverse=True)
        returned_jobs = [item[1] for item in job_sorted_list]
        print("\n\n jobs\n\n")
        for item in returned_jobs:
            print(item)
        response = {
            'jobs':returned_jobs
        }
        print("start sending")
        await websocket.send(json.dumps(response))
        print("done sending")
    






async def main():
    async with websockets.serve(get_course_video,"localhost",8765,max_size=1 * 1024 * 1024 * 1024):
        async with websockets.serve(add_medias,"localhost",8766,max_size=64 * 1024 * 1024 * 1024):
            async with websockets.serve(search,"localhost",8767):    
                async with websockets.serve(add_works,"localhost",8768,max_size=1 * 1024 * 1024 * 1024):
                    async with websockets.serve(get_works,"localhost",8769,max_size=32 * 1024 * 1024 * 1024):
                        async with websockets.serve(job_search,"localhost",8770):    
                            await asyncio.Future()

if __name__ == "__main__":
    asyncio.run(main())