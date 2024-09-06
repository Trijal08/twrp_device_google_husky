/*
 * Copyright (C) 2021 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "android.hardware.power.stats-service.pixel"

#include <dataproviders/DisplayStateResidencyDataProvider.h>
#include <dataproviders/PowerStatsEnergyConsumer.h>
#include <ZumaCommonDataProviders.h>
#include <PowerStatsAidl.h>

#include <android-base/logging.h>
#include <android-base/properties.h>
#include <android/binder_manager.h>
#include <android/binder_process.h>
#include <log/log.h>
#include <sys/stat.h>

using aidl::android::hardware::power::stats::DisplayStateResidencyDataProvider;
using aidl::android::hardware::power::stats::EnergyConsumerType;
using aidl::android::hardware::power::stats::PowerStatsEnergyConsumer;

void addDisplay(std::shared_ptr<PowerStats> p) {
    // Add display residency stats
    struct stat buffer;
    if (stat("/sys/class/drm/card0/device/primary-panel/time_in_state", &buffer)) {
        // time_in_state doesn't exist
        std::vector<std::string> states = {
            "Off",
            "LP: 1008x2244@1",
            "LP: 1008x2244@30",
            "On: 1008x2244@1",
            "On: 1008x2244@10",
            "On: 1008x2244@30",
            "On: 1008x2244@60",
            "On: 1008x2244@120",
            "HBM: 1008x2244@1",
            "HBM: 1008x2244@10",
            "HBM: 1008x2244@30",
            "HBM: 1008x2244@60",
            "HBM: 1008x2244@120",
            "LP: 1344x2992@1",
            "LP: 1344x2992@30",
            "On: 1344x2992@1",
            "On: 1344x2992@10",
            "On: 1344x2992@30",
            "On: 1344x2992@60",
            "On: 1344x2992@120",
            "HBM: 1344x2992@1",
            "HBM: 1344x2992@10",
            "HBM: 1344x2992@30",
            "HBM: 1344x2992@60",
            "HBM: 1344x2992@120"};

        p->addStateResidencyDataProvider(std::make_unique<DisplayStateResidencyDataProvider>(
                "Display",
                "/sys/class/backlight/panel0-backlight/state",
                states));
    } else {
        // time_in_state exists
        addDisplayMRR(p);
    }

    // Add display energy consumer
    p->addEnergyConsumer(PowerStatsEnergyConsumer::createMeterConsumer(
            p,
            EnergyConsumerType::DISPLAY,
            "DISPLAY",
            {"VSYS_PWR_DISPLAY"}));
}

int main() {
    LOG(INFO) << "Pixel PowerStats HAL AIDL Service is starting.";

    // single thread
    ABinderProcess_setThreadPoolMaxThreadCount(0);

    std::shared_ptr<PowerStats> p = ndk::SharedRefBase::make<PowerStats>();

    addZumaCommonDataProviders(p);
    addDisplay(p);

    const std::string instance = std::string() + PowerStats::descriptor + "/default";
    binder_status_t status = AServiceManager_addService(p->asBinder().get(), instance.c_str());
    LOG_ALWAYS_FATAL_IF(status != STATUS_OK);

    ABinderProcess_joinThreadPool();
    return EXIT_FAILURE;  // should not reach
}
