import React, { useState } from 'react';
import './App.css';
import Header from './Header';
import Sidebar from './Sidebar';
import { BrowserRouter, Route, Routes, Link } from 'react-router-dom';
import Requests from './Requests';
import Home from './Home';
import Complaints from './Complaints';
import Manegment from './Manegment';
import Users from './Users';
import Services from './Services';
import Jobs from './Jobs';
import Courses from './Courses';
import Addcategory from './Addcategory';

function App() {
  const [openSidebarToggle, setOpenSidebarToggle] = useState(false);

  const OpenSidebar = () => {
    setOpenSidebarToggle(!openSidebarToggle);
  };

  return (
    <BrowserRouter>
      <div className='grid-container'>
        <Header OpenSidebar={OpenSidebar} />
        <Sidebar openSidebarToggle={openSidebarToggle} OpenSidebar={OpenSidebar} />
        <Routes>
          <Route path="/Requests" element={<Requests />} />
          <Route path="/Complaints" element={<Complaints />} />
          <Route path='/Manegment/:u_id' element={<Manegment />} /> {/* Update the component prop to element */}
          <Route path="/Users" element={<Users />} />
          <Route path='/' element={<Home />} />
          <Route path='/Services' element={<Services />} />
          <Route path='/Courses' element={<Courses />} />
          <Route path='/Jobs' element={<Jobs />} />
          <Route path='/Addcategory' element={<Addcategory/>} />
          {/* Add other routes here */}
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;