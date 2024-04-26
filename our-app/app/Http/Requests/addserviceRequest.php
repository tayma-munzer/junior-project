<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class addserviceRequest extends FormRequest
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
            'email',
            'service_name',
            'service_price',
            'service_desc',
            'service_duration',
            'service_sec_type',
            'token',
            //
        ];
    }
}
