<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class register_request extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'f_name',
            'l_name',
            'age',
            'u_desc',
            'u_img_name',
            'u_img_data',
            'email',
            'username',
            'password',
            'gender',
            'preservation',
            'roles',
        ];
    }
}
