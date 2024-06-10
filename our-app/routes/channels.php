<?php

use Illuminate\Support\Facades\Broadcast;

Broadcast::channel('App.Models.User.{id}', function ($user, $id) {
    return (int) $user->id === (int) $id;
<<<<<<< HEAD
});
=======
});
>>>>>>> 391b65676a36c88db6196cb70bfd44cb6916e48d
