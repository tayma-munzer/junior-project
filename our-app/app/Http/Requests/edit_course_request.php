<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class edit_course_request extends FormRequest
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
            //
            'c_id',
            'u_id',
            'c_name',
            'c_desc',
            'c_price',
            'c_img',
            'c_duration',
            'pre_requisite',
            'ct_id',
            
        ];
    }
}
