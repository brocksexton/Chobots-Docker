package com.kavalok.dialogs
{
	import com.kavalok.Global;
	import com.kavalok.dto.MoneyReportTO;
	import com.kavalok.localization.ResourceBundle;
	import com.kavalok.services.CharService;
	import com.kavalok.utils.Strings;
	
	import flash.events.MouseEvent;

	public class DialogMoneyView extends DialogOkView
	{
		private static const bundle : ResourceBundle = Global.resourceBundles.kavalok;
		private var _content : DialogMoney = new DialogMoney(); 
		public function DialogMoneyView()
		{
			super(null, true, _content, true);
			new CharService(onGetReport).getMoneyReport();
			_content.inviteButton.addEventListener(MouseEvent.CLICK, onInviteClick);
		}
		
		private function onInviteClick(event : MouseEvent) : void
		{
			Dialogs.showInviteDialog();
		}
		private function onGetReport(result : MoneyReportTO) : void
		{
			var spent : Number = result.bonus + result.earned - Global.charManager.money; 
			_content.reportField.text = Strings.substitute(bundle.getMessage("financeReportText"),
				result.earned, spent, result.inviteesEarned, result.bonus);
		}
		
		
		
	}
}