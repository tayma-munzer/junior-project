<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class edit_alt_service_request extends FormRequest
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
            'a_id',
            'a_price',
            'a_name',
            'added_duration'
            //
        ];
    }
}
