package com.cpit.mqsender.dao;

import com.cpit.common.MyBatisDao;
import com.cpit.icp.dto.billing.balance.RechargeBean;
import com.cpit.icp.dto.billing.balance.RechargeEntity;
import com.cpit.icp.dto.billing.balance.UpdateUserDao;
import com.cpit.icp.dto.billing.baseconfig.BfAcctBalanceT;
import com.cpit.icp.dto.billing.consumption.ValueEntity;
import com.cpit.icp.dto.billing.recharge.BatchRechargeDto;
import com.cpit.icp.dto.crm.GroupCust;
import com.cpit.icp.dto.crm.User;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 
 * @author maming
 *
 */
@MyBatisDao
public interface BfAcctBalanceTMapper {
    
   
    int deleteByPrimaryKey(Long acctBalanceId);

    
    int insert(BfAcctBalanceT record);

    
    int insertSelective(BfAcctBalanceT record);

    
    BfAcctBalanceT selectByPrimaryKey(Long acctBalanceId);

   
    int updateByPrimaryKeySelective(BfAcctBalanceT record);
 
    
    int updateByPrimaryKey(BfAcctBalanceT record);

	/**
	 * updatAcctBalance(这里用一句话描述这个方法的作用)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param bfAcctBalanceT 
	 *void
	 * @return 
	 * @exception 
	 * @since  1.0.0
	*/
	public Integer updateAcctBalance(BfAcctBalanceT bfAcctBalanceT);


	/**
	 * selectBfAcctBalanceTInfo(这里用一句话描述这个方法的作用)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param acctId
	 * @return 
	 *List<BfAcctBalanceT>
	 * @exception 
	 * @since  1.0.0
	*/
	List<BfAcctBalanceT> selectBfAcctBalanceTInfo(BfAcctBalanceT bfAcctBalanceT);


	/**
	 * addAccountsMethod(在账本余额表中添加账本)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param bfAcctBalanceList
	 * @return 
	 *Integer
	 * @exception 
	 * @since  1.0.0
	*/
	public void addAccountsMethod(List<BfAcctBalanceT> bfAcctBalanceList);

	/**
	 * selectBalanceByAcctIdWithPriority查询带优先级的用户账本,按照优先级降序排序
	 * (这里描述这个方法适用条件 – 可选)
	 * @param acctId
	 * @return 
	 *List<BfAcctBalanceT>
	 * @exception 
	 * @since  1.0.0
	*/
	List<BfAcctBalanceT> selectBalanceByAcctIdWithPrioritySort(Long acctId);

	//账本有效期延长
	int updateExDateByKey(BfAcctBalanceT acct);


	/**
	 * updateAcctsBalance(针对用户退网退费的方法)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param bfAcctBalanceT 
	 *void
	 * @exception 
	 * @since  1.0.0
	*/
	public void updateAcctsBalance(@Param("bfList")List<BfAcctBalanceT> bfList);


	/**
	 * getAccoutBook(根据账号和账本类型查询对应的账本是否存在)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param bfAcctBalanceT 
	 *void
	 * @exception 
	 * @since  1.0.0
	*/
	int getAccoutBookCount(BfAcctBalanceT bfAcctBalanceT);

	List<BfAcctBalanceT> selectBalanceByAcctIdWithPrioritySortFromDefaultScheme(Long acctId);


	/**
	 * updateBatchAccountBalance(这里用一句话描述这个方法的作用)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param rechargeEntityList 
	 *void
	 * @exception 
	 * @since  1.0.0
	*/
	public void updateBatchAccountBalance(List<RechargeEntity> rechargeEntityList);


	/**
	 * updateAccountBalance(这里用一句话描述这个方法的作用)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param rechargeEntityList 
	 *void
	 * @exception 
	 * @since  1.0.0
	*/
	void updateAccountBalance(RechargeEntity rechargeEntity);
	//获取主账户金额
	public BfAcctBalanceT getMainAccountBalance(ValueEntity ve);
	//获取副账号金额
	public BfAcctBalanceT getCurrentAccountBalance(ValueEntity ve);


	/**
	 * deductAccountsService(扣账服务)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param bfAcctBalanceT 
	 *void
	 * @exception 
	 * @since  1.0.0
	*/
	public Integer deductAccountsService(BfAcctBalanceT bfAcctBalanceT);


	/**
	 * batchSelectAccountBalanceByAccountIds(这里用一句话描述这个方法的作用)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param userAccountList 
	 *void
	 * @exception 
	 * @since  1.0.0
	*/
	public List<BfAcctBalanceT> batchSelectAccountBalanceByAccountIds(List<Integer> userAccountList);


	/**
	 * getGroupBFundAndGiftBalance(这里用一句话描述这个方法的作用)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param groupId 
	 *void
	 * @exception 
	 * @since  1.0.0
	*/
	List<BfAcctBalanceT> getGroupBFundAndGiftBalance(String groupId);
	List<BfAcctBalanceT> getGroupBUserFundAndGiftBalance(@Param(value="groupId")String groupId,@Param(value="cardId")String cardId);


	/**
	 * getAcctBalance(这里用一句话描述这个方法的作用)
	 * (这里描述这个方法适用条件 – 可选)
	 * @param cardId 
	 *void
	 * @exception 
	 * @since  1.0.0
	*/
	
	public BfAcctBalanceT getAcctBalance(String cardId);


	List<BfAcctBalanceT> selectAll(@Param("count")Integer count);


	List<BfAcctBalanceT> selectAcctInfos(@Param("acctId")String acctId,@Param("acctBalanceId")String acctBalanceId);


	void updateAcctInfos(RechargeBean rb);

	//不更新操作时间，只更新balance字段，适用于割接
	void updateAcctsBalanceByKey(@Param("bfList")List<BfAcctBalanceT> bfList);
	//仅适用于网厅个人充值
	Integer getPersonolUserAccountByCardId(String cardId);
	//根据卡号获取当前卡号余额
	List<BfAcctBalanceT> queryAcctBalancesBycardId(String cardId);
	
	//获取余额等于0的账户信息
	List<BfAcctBalanceT> getBalanceEqualZeroInfo();

	//批量更新服务状态
	void updateBatchServiceStatus(@Param("bfList")List<BfAcctBalanceT> bfList);

	//从东软的bf_acct_item_t表中获取同一个acct_id对应的amount金额之和合计
	List<BfAcctBalanceT>  batchQueryItemAmount(@Param("bfList")List<BfAcctBalanceT> bfList);

	//割接
	BfAcctBalanceT  selectUserIdByAcctId(BfAcctBalanceT bf1);

	//割接
	List<BfAcctBalanceT> getEligibleUsers(String cityCode);

	//割接
	List<Integer> queryGroupAcct(String cityCode);

	//割接
	List<Integer> queryUserAcct(String cityCode);

	//割接
	List<Integer> getBfAcctIds(String cityCode);

	//割接
	List<BfAcctBalanceT> queryUserAcctInfo(@Param("reList")List<Integer> reList);
	//给xqs提供的清楚账户余额的接口 scx--二期开发 一期同步
	void clearAcctBalances(Integer acctId);

	//批量更新用户信息
	void batchUpdateUserStatus(UpdateUserDao updateUserDao);
	
	//根据主键返回
	BigDecimal selectByAcctBalanceId(long acct_balance_id);
	
	//根据退费更新余额
	void updateBalanceByAcctBalanceId(@Param("acct_balance_id")Long acct_balance_id,@Param("balance")BigDecimal balance);


	public List<BfAcctBalanceT> queryMiniProgramsBalanceByUserId(Integer servId);
	
	//二期移植2019年12月12日14:36:04
	List<BfAcctBalanceT> queryAcctInfosByServId(Integer servId);
	//二期移植2019年12月12日14:39:49
	void updateAcctBalanceByacctBalanceId(BfAcctBalanceT bfAcctBalanceT);

	List<BfAcctBalanceT> queryBalancesBycardIds(@Param("cardIdList")List<String> cardIdList);


	void updateBatchAccountBalanceByKey(List<BfAcctBalanceT> acctInfos);


	void updateAcctsBalanceByUserId(BatchRechargeDto batchRechargeDto);


	List<BfAcctBalanceT> queryBalancesByUserIds(BatchRechargeDto batchRechargeDto);


	List<BfAcctBalanceT> getGroupBMainAcctFundAndGiftBalance(String groupId);


	void batchUpdateUserServiceStatus(BatchRechargeDto batchRechargeDto);

	List<BfAcctBalanceT> getAllUserSchemeBalance(Long acctId);
    Integer getGroupBMainAccount(String groupId);

	BigDecimal selectBatchAccountBalanceAccAmount(BatchRechargeDto batchRechargeDto);

	void clearAcctBalancesToType1(@Param("acctId") Integer acctId,@Param("refundAmount")  String refundAmount);
	void clearAcctBalancesToType2(@Param("acctId") Integer acctId);

	Integer queryUserTypeByUserId(Integer userId);

	String getGroupBId(Integer acctId);

	BfAcctBalanceT selectByAcctIdAndBalanceTypeId(BfAcctBalanceT bfAcctBalanceT);

    GroupCust getgroupBCustById(@Param("groupId") String groupId);

	BfAcctBalanceT getAcctBalanceToUserIdAndTypeId(@Param("userId") Integer userId, @Param("balanceTypeId") Integer balanceTypeId);

    BfAcctBalanceT getGroupBUserFundBalance(@Param("groupId") String groupId);

	void insertCenterTransNo(@Param("centerTransId") String centerTransId,@Param("deviceNo") String deviceNo,
	@Param("objId") String objId,@Param("reqSystemId") String reqSystemId);
}