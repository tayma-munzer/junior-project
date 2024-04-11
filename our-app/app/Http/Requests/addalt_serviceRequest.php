<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class addalt_serviceRequest extends FormRequest
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
            's_id',
            'a_name',
            'a_price',
            'added_duration',
        ];
    }
}
