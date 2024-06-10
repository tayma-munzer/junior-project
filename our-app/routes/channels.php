<?php

use Illuminate\Support\Facades\Broadcast;

Broadcast::channel('App.Models.User.{id}', function ($user, $id) {
    return (int) $user->id === (int) $id;
});
<<<<<<< HEAD
=======

>>>>>>> f8ce7e7ed9e4dbb6dad91119a007067a8c346b4a
