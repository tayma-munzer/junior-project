<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class get_courses_type_request extends FormRequest
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
            'ct_id',
            'ct_type',
            'ct_icon',
            //
        ];
    }
}
