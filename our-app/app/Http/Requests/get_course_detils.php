<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class get_course_detils extends FormRequest
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
            'cd_id',
            'cd_id',
            'cd_name',
            'cd_desc',
            'cd_price',
            'cd_img',
            'c_id',
            'cd_duration',
            'cd_pre_requisite',
            //
        ];
    }
}
