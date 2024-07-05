<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class edit_job_request extends FormRequest
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
            'j_id',
            'j_title',
            'j_desc',
            'j_req',
            'j_min_sal',
            'j_max_sal',
            'j_min_age',
            'j_max_age',
            'education',
            'num_of_exp_years'
        ];
    }
}
