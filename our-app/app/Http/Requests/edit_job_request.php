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
            'j_sal',
            'j_name',
            'j_desc',
            'j_req',
            //
        ];
    }
}
