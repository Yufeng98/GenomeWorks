/*
* Copyright (c) 2019-2020, NVIDIA CORPORATION.  All rights reserved.
*
* NVIDIA CORPORATION and its licensors retain all intellectual property
* and proprietary rights in and to this software, related documentation
* and any modifications thereto.  Any use, reproduction, disclosure or
* distribution of this software and related documentation without an express
* license agreement from NVIDIA CORPORATION is strictly prohibited.
*/

#pragma once

#include <vector>
#include <string>

namespace claragenomics
{

struct TestCaseData
{
    std::string target;
    std::string query;
    int32_t edit_distance;
};

std::vector<TestCaseData> create_myers_test_cases();

} // namespace claragenomics
