/*
* Copyright 2019-2020 NVIDIA CORPORATION.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

#pragma once

#include "matrix_cpu.hpp"
#include "batched_device_matrices.cuh"

#include <cuda_runtime_api.h>

namespace claraparabricks
{

namespace genomeworks
{

namespace cudaaligner
{

namespace myers
{
using WordType              = uint32_t;
constexpr int32_t word_size = sizeof(WordType) * CHAR_BIT;
} // namespace myers

int32_t myers_compute_edit_distance(std::string const& target, std::string const& query);
matrix<int32_t> myers_get_full_score_matrix(std::string const& target, std::string const& query);

void myers_gpu(int8_t* paths_d, int32_t* path_lengths_d, int32_t max_path_length,
               char const* sequences_d,
               int32_t const* sequence_lengths_d,
               int32_t max_target_query_length,
               int32_t n_alignments,
               batched_device_matrices<myers::WordType>& pv,
               batched_device_matrices<myers::WordType>& mv,
               batched_device_matrices<int32_t>& score,
               batched_device_matrices<myers::WordType>& query_patterns,
               cudaStream_t stream);

int32_t myers_banded_gpu_get_blocks_per_sm();

void myers_banded_gpu(int8_t* paths_d, int32_t* path_counts_d, int32_t* path_starts_d, uint32_t* path_metadata_d,
                      char const* sequences_d,
                      int64_t const* sequence_starts_d,
                      int32_t const* max_bandwidths_d,
                      int32_t* scheduling_index_d,
                      int32_t* scheduling_atomic_d,
                      batched_device_matrices<myers::WordType>& pv,
                      batched_device_matrices<myers::WordType>& mv,
                      batched_device_matrices<int32_t>& score,
                      batched_device_matrices<myers::WordType>& query_patterns,
                      int8_t* path_buffer_d,
                      int32_t* path_counts_buffer_d,
                      int32_t path_buffer_size,
                      int32_t n_alignments,
                      int32_t n_launch_blocks,
                      int32_t n_large_workspaces,
                      cudaStream_t stream);
} // namespace cudaaligner

} // namespace genomeworks

} // namespace claraparabricks
