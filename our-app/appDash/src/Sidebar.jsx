import React from 'react';
import { Link } from 'react-router-dom';
import 
{ BsGrid1X2Fill, BsFillArchiveFill, BsPeopleFill,BsFillBellFill}
 from 'react-icons/bs';
 import { FaPercent, FaMoneyBill,FaUser } from 'react-icons/fa';
function Sidebar({openSidebarToggle}) {
  return (
    <aside id="sidebar" className={openSidebarToggle ? "sidebar-responsive": ""}>
       <div className='sidebar-title'></div>

        <ul className='sidebar-list'>
            <li className='sidebar-list-item'>
                <Link to="/">
                    <BsGrid1X2Fill className='icon'/> لوحة التحكم
                </Link>
            </li>
            <li className='sidebar-list-item'>
                <Link to="/Requests">
                    <BsFillArchiveFill className='icon'/> الطلبات
                </Link>
            </li>
            
            <li className='sidebar-list-item'>
                <Link to="/Users">
                    <BsPeopleFill className='icon'/> إدارة الحسابات
                </Link>
            </li>
            
            <li className='sidebar-list-item'>
                <Link to="/Complaints">
                    <BsFillBellFill className='icon'/> الشكاوي
                </Link>
            </li>
            
           
        </ul>
    </aside>
  )
}

export default Sidebar