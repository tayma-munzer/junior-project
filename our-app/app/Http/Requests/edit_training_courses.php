<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class edit_training_courses extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return false;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
        't_id',
        'cv_id',
        'course_name',
        'training_center',
        'completion_date',
        ];
    }
}
