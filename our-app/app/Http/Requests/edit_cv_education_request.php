<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class edit_cv_education_request extends FormRequest
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
            'cv_id',
            'degree',
            'uni',
            'field_of_study',
            'grad_year',
            'gba',
            //
        ];
    }
}
