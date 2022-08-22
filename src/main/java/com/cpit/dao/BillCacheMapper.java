package com.cpit.dao;

import com.cpit.common.MyBatisDao;
import com.cpit.icp.dto.billing.baseconfig.BbBusinessParamT;
import com.cpit.icp.dto.billing.baseconfig.BfAcctBalanceT;
import com.cpit.icp.dto.billing.baseconfig.BfPowerLossRateConfigT;
import com.cpit.icp.dto.billing.connectivity.BfBusinessStrategyT;
import com.cpit.icp.dto.billing.deductionfee.Accumulate;
import com.cpit.icp.dto.billing.deductionfee.BfIndbDetailRecordKey;
import com.cpit.icp.dto.billing.deductionfee.GroupBGroupId2AccountId;
import com.cpit.icp.dto.billing.prod.basicelectricityprice.BEBfIndbBaseConfigT;
import com.cpit.icp.dto.billing.prod.offer.BbProdOffer;
import com.cpit.icp.dto.billing.prod.rule.BfRuleConfigT;
import com.cpit.icp.dto.billing.prod.scene.BfFavourPublicInfoT;
import com.cpit.icp.dto.billing.prod.scene.BfRateSceneConfigT;
import com.cpit.icp.dto.billing.prod.scene.BfTimeSceneConfigT;
import com.cpit.icp.dto.billing.prod.scheme.BfRebateAttrTKey;
import com.cpit.icp.dto.billing.prod.scheme.BfRebateObjT;
import com.cpit.icp.dto.billing.prod.scheme.BfRebatePlanT;
import com.cpit.icp.dto.billing.prod.tariffconfiguration.BfPricingCombineT;
import com.cpit.icp.dto.billing.prod.tariffconfiguration.BfPricingPlanT;
import com.cpit.icp.dto.billing.prod.tariffconfiguration.BfPricingSectionT;
import com.cpit.icp.dto.billing.prod.tariffconfiguration.BfTariffT;
import com.cpit.icp.dto.crm.GroupCust;
import com.cpit.icp.dto.crm.GroupUser;
import com.cpit.icp.dto.crm.MonthUser;
import com.cpit.icp.dto.resource.BrBatterycharge;

import java.util.List;

/**
* 类名称：BillCacheMapper
* 类描述：计费流程用缓存数据库数据
* 创建人：maming
* 创建时间：2019年5月24日 下午2:05:30
* 修改人：
* 修改时间：
* 修改备注：
* @version 1.0.0
*/
@MyBatisDao
public interface BillCacheMapper {
   public List<GroupUser> getAllGroupUser();
   GroupUser getGroupUserByCardId(String cardId);
   List<BrBatterycharge> getAllBatteryCharge();
   List<BbProdOffer> getAllOffer();
   List<BfRuleConfigT> getAllRuleConfig();
   List<Accumulate> getAllCumulate();
   List<BfTimeSceneConfigT> getAllTimeScene();
   List<BfRateSceneConfigT> getAllRateScene();
   List<BfFavourPublicInfoT> getAllFavourPublicInfo();
   List<BfPricingPlanT> getAllPricingPlan();
   List<BfPricingCombineT> getAllPricingCombineEle();
   List<BfPricingCombineT> getAllPricingCombineService();
   List<BfPricingSectionT> getAllPricingSectionByEventPricingStrategyId();
   List<BfTariffT> getAllTariff();
   List<BfRebateObjT> getAllRebateObj();
   List<BfRebateAttrTKey> getAllRebateAttr();
   List<BfRebatePlanT> getAllRebatePlan();
//	List<BfRebatePlanT> getAllNoPoleRebatePlan();
   List<GroupCust> getAllGroupBCustFullInfo();
   List<BfAcctBalanceT> getAllDefaultSchemeBalance();
   List<BfAcctBalanceT> getAllUserSchemeBalance();
   BbBusinessParamT getOverTimeParam();
   List<BfIndbDetailRecordKey> getHotRecord();
   List<BEBfIndbBaseConfigT> getBaseConfig();
   List<GroupBGroupId2AccountId> getGroupBGroupId2UserAccountIdList();
   List<GroupBGroupId2AccountId> getGroupBGroupId2MainAccountId();
   List<BbBusinessParamT> getAllBusinessParam();
   List<BfBusinessStrategyT> selectAllBfBusinessStrategyT();
   List<MonthUser> updateAllMonthUser();
   List<BfPowerLossRateConfigT> selectPowerLoss();
   public List<String> getAllCard();
}